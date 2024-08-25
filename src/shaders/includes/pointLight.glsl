vec3 pointLight(vec3 lightColor, float lightIntensity, vec3 normal, vec3 lightPosition, vec3 viewDirection, float specularPower, vec3 position, float lightDecay) {
    
    vec3 lightDelta = lightPosition - position; 
    vec3 lightDirection = normalize(lightDelta);
    vec3 reflection = reflect( - lightDirection, normal);
    float lightDistance = length(lightDelta);

    // shading
    float shading = dot(normal, lightDirection);
    shading = max(0.0, shading);

    // specular
    float specular = - dot(reflection, viewDirection);
    specular = max(0.0, specular);
    specular = pow(specular, specularPower);

    // decay
    float decay = 1.0 - lightDistance * lightDecay; 
    decay = max(0.0, decay);


  return lightColor * lightIntensity * decay * (shading +  specular);

}