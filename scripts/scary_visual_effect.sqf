

["ChromAberration", 200, [0.15, 0.05, true], _this] spawn {
    params ["_name", "_priority", "_effect", "_timeParams", "_handle"];
    _fadeInTime = _timeParams select 0;
    _staticEffectTime = _timeParams select 1;
    _fadeOutTime = _timeParams select 2;

    while {
        _handle = ppEffectCreate [_name, _priority];
        _handle < 0
    } do {
        _priority = _priority + 1;
    };
    _handle ppEffectEnable true;
    _handle ppEffectAdjust _effect;
    _handle ppEffectCommit _fadeInTime;
    waitUntil { ppEffectCommitted _handle };
    // systemChat "admire effect for a sec";
    uiSleep _staticEffectTime;
    _handle ppEffectAdjust [0, 0, false];
    _handle ppEffectCommit _fadeOutTime;
    waitUntil { ppEffectCommitted _handle };
    _handle ppEffectEnable false;
    ppEffectDestroy _handle;
};

//["RadialBlur", 100, [0.05, 0.05, 0.2, 0.2], _this] spawn
//{
//    params ["_name", "_priority", "_effect", "_timeParams", "_handle"];
//    _fadeInTime = _timeParams select 0;
//    _staticEffectTime = _timeParams select 1;
//    _fadeOutTime = _timeParams select 2;
//
//    while {
//        _handle = ppEffectCreate [_name, _priority];
//        _handle < 0
//    } do {
//        _priority = _priority + 1;
//    };
//    _handle ppEffectEnable true;
//    _handle ppEffectAdjust _effect;
//    _handle ppEffectCommit _fadeInTime;
//    waitUntil { ppEffectCommitted _handle };
//    systemChat "admire effect for a sec";
//    uiSleep _staticEffectTime;
//    _handle ppEffectAdjust [0, 0, 0, 0];
//    _handle ppEffectCommit _fadeOutTime;
//    _handle ppEffectEnable false;
//    ppEffectDestroy _handle;
//};
