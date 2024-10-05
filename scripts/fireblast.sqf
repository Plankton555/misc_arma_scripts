

//private _posATL = player modelToWorld [0,10,0];
private _posATL = _this select 0;

// Fire
private _ps1 = "#particlesource" createVehicleLocal _posATL;
//_ps1 setParticleParams [
//    ["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 10, 32], "", "Billboard",
//    1, 1, [0, 0, 0], [0, 0, 0.5], 0, 1, 1, 3, [0.5,1.5],
//    [[1,1,1,0.4], [1,1,1,0.2], [1,1,1,0]],
//    [0.25,1], 1, 1, "", "", _ps1];
//_ps1 setParticleRandom [0.2, [0.5, 0.5, 0.25], [0.125, 0.125, 0.125], 0.2, 0.2, [0, 0, 0, 0], 0, 0];
//_ps1 setDropInterval 0.05;
_ps1 setParticleClass "ObjectDestructionFire1Smallx";
//_ps1 setParticleClass "FireBallBrightSmall";
_ps1 setParticleFire [0,0,0];

// Smoke
private _ps2 = "#particlesource" createVehicleLocal _posATL;
_ps2 setParticleParams [
    ["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 7, 16, 1], "", "Billboard",
    1, 8, [0, 0, 0], [0, 0, 1.5], 0, 10, 7.9, 0.066, [1, 3, 6],
    [[0, 0, 0, 0], [0.05, 0.05, 0.05, 1], [0.05, 0.05, 0.05, 1], [0.05, 0.05, 0.05, 1], [0.1, 0.1, 0.1, 0.5], [0.125, 0.125, 0.125, 0]],
    [0.25], 1, 0, "", "", _ps1];
_ps2 setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
_ps2 setDropInterval 0.05;

// Light
private _lightpoint = "#lightpoint" createVehicle _posATL;
_lightpoint setLightDayLight true;
_lightpoint setLightColor [1.0, 0.5, 0.0];
_lightpoint setLightBrightness 0.2;
_lightpoint setLightAmbient [1.0, 0.5, 0.0];
_lightpoint setLightAttenuation [3, 0, 0, 0.6];

// Cleanup, remove the stuff after time's up
[_ps1, _ps2, _lightpoint, 0.5] spawn {
    _ps1 = _this select 0;
    _ps2 = _this select 1;
    _lp = _this select 2;
    _lifeTime = _this select 3;

    uisleep _lifeTime;
    deleteVehicle _ps1;
    deleteVehicle _ps2;
    uisleep _lifeTime * 0.5;
    deleteVehicle _lp;
};
