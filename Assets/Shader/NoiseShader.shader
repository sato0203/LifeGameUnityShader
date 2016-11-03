Shader "Unlit/NoiseShader"
{
	Properties
	{
		_Seed("Seed",Int) = 10
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
				float2 appDataUv : TEXCOORD1;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			//関数
			int _Seed;
 
			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.appDataUv=v.uv;
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}

			fixed4 GetWhiteOrBlack(float2 uv)
			{
				float value = frac(sin((dot(uv.xy,float2(12.9898,78.233))+_Seed)* 43758.5453));
				if(value>0.5)
					value=1;
				else
					value=0;
				return fixed4(value,value,value,0);
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				return GetWhiteOrBlack(i.appDataUv*10);
			}
			ENDCG
		}
	}
}
