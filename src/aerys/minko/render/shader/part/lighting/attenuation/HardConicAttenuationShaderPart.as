package aerys.minko.render.shader.part.lighting.attenuation
{
	import aerys.minko.render.effect.lighting.LightingProperties;
	import aerys.minko.render.shader.SFloat;
	import aerys.minko.render.shader.Shader;
	import aerys.minko.render.shader.part.lighting.LightAwareShaderPart;
	
	public class HardConicAttenuationShaderPart extends LightAwareShaderPart implements IAttenuationShaderPart
	{
		public function HardConicAttenuationShaderPart(main : Shader)
		{
			super(main);
		}
		
		public function getAttenuation(lightId : uint, wPos : SFloat, wNrm : SFloat, iwPos : SFloat, iwNrm : SFloat) : SFloat
		{
			var lightWorldPosition	: SFloat = getLightParameter(lightId, 'worldPosition', 3);
			var lightWorldDirection	: SFloat = getLightParameter(lightId, 'worldDirection', 3);
			var lightRadius			: SFloat = getLightParameter(lightId, 'outerRadius', 1);
			
			var lightRadiusCosine	: SFloat = cos(divide(lightRadius, 2));
			var lightToPoint		: SFloat = subtract(iwPos, lightWorldPosition);
			var lightAngleCosine	: SFloat = dotProduct3(lightWorldDirection, normalize(lightToPoint));
			
			return greaterEqual(lightAngleCosine, lightRadiusCosine);
		}
	}
}
