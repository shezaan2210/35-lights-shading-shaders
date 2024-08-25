uniform vec3 uColor;

varying vec3 vNormal;
varying vec3 vPosition;

#include ../includes/ambientLight.glsl
#include ../includes/directionalLight.glsl
#include ../includes/pointLight.glsl



void main()
{
    vec3 normal = normalize(vNormal);
    vec3 viewDirection = normalize(vPosition - cameraPosition);
    vec3 color = uColor;

    // Light
    vec3 light = vec3(0.0);


    // ambient light
    light += ambientLight(
        vec3(1.0), // Light color
         .05  // light intensity
         );


    // //  directional light
    light += directionalLight(
        vec3(.1, .1, 1.0), //light color
        1.0,   // light intensity
        normal, // normal
        vec3(0.0, 0.0, 3.0),  // light position
        viewDirection, // view direction
        20.0  // specular power
    );

    // point light
      light += pointLight(
        vec3(1.0, .1, 0.1), //light color
        1.0,   // light intensity
        normal, // normal
        vec3(0.0, 2.0, 0.0),  // light position
        viewDirection, // view direction
        20.0,  // specular power
        vPosition, // position
        .3  // decay
    );

    // light
    color *= light;

    // Final color
    gl_FragColor = vec4(color, 1.0);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}