using UnityEngine;
using System.Collections;

public class LifeGameShaderManager : MonoBehaviour {

	[SerializeField]
	private Shader lifeGameShader;
	[SerializeField]
	private Shader unlitTextureShader;
	[SerializeField]
	private RenderTexture curRenderTexture;
	[SerializeField]
	private RenderTexture prevRenderTexture;
	private Texture startTexture;
	private Material copyMaterial;
	[SerializeField]
	private Material initMaterial;
	private Material lifeGameMaterial;

	bool flag = false;

	private float elapsedSeconds;

	// Use this for initialization
	void Awake () {
		copyMaterial = new Material(unlitTextureShader);
		lifeGameMaterial = new Material(lifeGameShader);
		Graphics.Blit(null, curRenderTexture, initMaterial);
	}
	
	// Update is called once per frame
	void Update () {
		elapsedSeconds += Time.deltaTime;
		if (elapsedSeconds > 0.1f)
		{
			Graphics.Blit(curRenderTexture, prevRenderTexture, copyMaterial);
			Graphics.Blit(curRenderTexture, curRenderTexture, lifeGameMaterial);
			elapsedSeconds = 0;
			Debug.Log("aa");
		}
	}
}
