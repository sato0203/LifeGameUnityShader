Shader "Unlit/lifeGame"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _MainTex_TexelSize;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				//最終出力用
				fixed4 outColor;
				fixed4 white = fixed4(1,1,1,1);
				fixed4 black = fixed4(0,0,0,1);
				
				//周辺の色情報用変数
				float4 texelSize=_MainTex_TexelSize;
				fixed4 colorSurrounds[3][3];
				int aliveSurroundsNum=0;//周辺の生きてるマスの数

				for(int j=0;j<3;j++)
				{
					for(int k=0;k<3;k++)
					{
						float2 uvSurrounds;
						uvSurrounds.x=i.uv.x+(j-1)*texelSize.x;
						uvSurrounds.y=i.uv.y+(k-1)*texelSize.y;
						colorSurrounds[j][k]=tex2D(_MainTex, uvSurrounds);

						//alliveSurroundsNumの個数を計算
						//j=1のときk=1のときは自分自身のマスなので除外
						if(j !=1 && k != 1)
						{
							if(colorSurrounds[j][k].r>0.5)
							{
								aliveSurroundsNum = aliveSurroundsNum+1;
							}
						}
					}
				}

				//ライフゲームの進行


				//死んでる場合
				if(colorSurrounds[1][1].r<0.5)
				{
					if(aliveSurroundsNum == 3)
					{
						outColor = white;
					}
					else
					{
						outColor = black;
					}
				}
				//生きてる場合
				else
				{
					if(aliveSurroundsNum == 2 || aliveSurroundsNum == 3)
					{
						outColor = white;
					}
					if(aliveSurroundsNum >=4)
					{
						outColor = black;
					}
					if(aliveSurroundsNum <=1)
					{
						outColor = black;
					}
				}

				return outColor;
			}
			ENDCG
		}
	}
}
