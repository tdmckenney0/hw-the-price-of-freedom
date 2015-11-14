// Modified by CnlPepper to implement bright specular reflections

static Texture $diffuse
//static Texture $glow

simple base(Texture $diffuse, Texture $glow, Texture $normal, Colour $teambase, Colour $teamstripe, Colour $fogColour, Colour $addColour, Colour $shadowColour)
{
    setCap depthBufferCap	true
    setCap gouraudCap		true
    setCap cullCap		true
    setCap texture0Cap		true
    setCap texture1Cap		true
    setCap lightingCap		true
    setCap fragmentProgramCap	true
    setCap separateSpecularCap	true
    setCap colourMaterialCap	true
    setCap blendCap         	true

    srcBlend srcAlphaBlend
    destBlend invSrcAlphaBlend

    fillMode solidFill
    cullMode backCull

    material ambient   1 1 1 1
    material diffuse   1 1 1 1
    material specular  1 1 1 1
    material shininess 96 96 96 96
    setVertexColour    1 1 1 1

    textureBind 0 $diffuse
    textureBind 1 $glow

    setFragmentProgram shipFragmentProgram

    setProgramVarLocal fragmentProgram 0x0 0.5 0.5 0.5 0.5	// glow colour multiplier    
    setProgramVarLocal fragmentProgram 0x1 $teambase
    setProgramVarLocal fragmentProgram 0x2 $teamstripe
    setProgramVarLocal fragmentProgram 0x3 $fogColour
}

simple additive(Texture $diffuse, Texture $glow, Texture $normal, Colour $teambase, Colour $teamstripe, Colour $fogColour, Colour $addColour, Colour $shadowColour)
{
    setCap depthBufferCap 	true
    setCap gouraudCap 		true
    setCap blendCap 		true
    setCap cullCap  		true

    srcBlend srcAlphaBlend
    destBlend oneBlend

    fillMode solidFill
    cullMode backCull

    material ambient   1 1 1 1
    material diffuse   1 1 1 1
    material specular  1 1 1 1
    material shininess 96 96 96 96
    setVertexColour    $addColour

    setFragmentProgram additiveFragmentProgram

    setProgramVarLocal fragmentProgram 0x0 $addColour
}

compound matte()
{
    addPass base
    addPass additive 0
}

