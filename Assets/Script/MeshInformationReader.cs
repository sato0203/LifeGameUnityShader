using UnityEngine;
using System.Collections;

public class MeshInformationReader : MonoBehaviour {

	private MeshFilter meshFilter;

	// Use this for initialization
	void Start () {
		meshFilter = GetComponent<MeshFilter>();
		Debug.Log("vertices");
		foreach (var obj in meshFilter.mesh.vertices)
		{
			Debug.Log(obj);
		}
		Debug.Log("triangles");
		foreach (var obj in meshFilter.mesh.triangles)
		{
			Debug.Log(obj);
		}
		Debug.Log("uvs");
		foreach (var obj in meshFilter.mesh.uv)
		{
			Debug.Log(obj);
		}
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
