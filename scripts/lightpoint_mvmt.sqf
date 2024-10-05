
_positions = _this select 0;
_times = _this select 1;

start_pos = _positions select 0;

_lightpoint = "#lightpoint" createVehicle start_pos;

// _lightpoint setLightColor [1.0, 0.1, 0.1];
// _lightpoint setLightUseFlare true;
// _lightpoint setLightFlareSize 0.5;
// _lightpoint setLightFlareMaxDistance 500;
// _lightpoint setLightBrightness 0.5;
// _lightpoint setLightIntensity 1000;
// _lightpoint setLightDayLight true;

// skipTime -dayTime;

// TODO not sure, but this might be executed on every client
[_lightpoint, [1.0, 0.1, 0.1]] remoteExec ["setLightColor", 0, _lightpoint];
[_lightpoint, true] remoteExec ["setLightUseFlare", 0, _lightpoint];
[_lightpoint, 0.5] remoteExec ["setLightFlareSize", 0, _lightpoint];
[_lightpoint, 500] remoteExec ["setLightFlareMaxDistance", 0, _lightpoint];
[_lightpoint, 0.5] remoteExec ["setLightBrightness", 0, _lightpoint];
[_lightpoint, 1000] remoteExec ["setLightIntensity", 0, _lightpoint];
[_lightpoint, true] remoteExec ["setLightDayLight", 0, _lightpoint];


// TODO could this be different on different clients?
// Audio length: fox_1 is 14s, fox_2 is 24s
_lightpoint say3D selectRandom ["fox_1", "fox_2"];


_start_time = time;
_absolute_times = [];

{ _absolute_times pushBack (_start_time + _x); } forEach _times;


["lightpoint", "onEachFrame", {
    _lp = _this select 0;
    _positions = _this select 1;
    _times = _this select 2;

    if ( time < _times select 0 ) exitWith {
        false; // before first time
    };

    _last_idx = (count _times) - 1;
    if ( time > _times select _last_idx ) exitWith {
        false; // after last time
    };

    _current_idx = 0;
    {
        if ( time > _x ) then {
            _current_idx = _current_idx + 1;
        } else {
            break;
        };
    } forEach _times;

    _from_pos = _positions select (_current_idx - 1);
    _from_time = _times select (_current_idx - 1);
    _to_pos = _positions select (_current_idx);
    _to_time = _times select (_current_idx);

    // Could potentially extend this by using bezierInterpolation instead
    x_interp = linearConversion [_from_time, _to_time, time, _from_pos select 0, _to_pos select 0];
    y_interp = linearConversion [_from_time, _to_time, time, _from_pos select 1, _to_pos select 1];
    z_interp = linearConversion [_from_time, _to_time, time, _from_pos select 2, _to_pos select 2];

    _lp setPos [x_interp, y_interp, z_interp]; // should be ok to call locally here
}, [_lightpoint, _positions, _absolute_times]] call BIS_fnc_addStackedEventHandler;


// Cleanup, remove the lightpoint after time's up
[_lightpoint, _absolute_times] spawn {
    _lp = _this select 0;
    _absolute_times = _this select 1;

    _last_idx = (count _absolute_times) - 1;
    _end_time = _absolute_times select _last_idx;
    while { time < _end_time } do
    {
        sleep 0.2;
    };
    deleteVehicle _lp;
    ["lightpoint", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
};
