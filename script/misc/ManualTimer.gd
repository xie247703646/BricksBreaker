extends Reference
class_name ManualTimer

const RUNNING = -1

var _wait_time:float = 0
var _cur_time:float = 0.0
var _total_time:float = 0.0
var _is_ticking:bool = false

func tick(delta:float)->int:
	if is_stopped(): return FAILED
	if is_paused(): return FAILED
	_cur_time += delta
	_total_time += delta
	if _cur_time >= _wait_time:
		_cur_time = 0.0
		return OK
	return -1

func start(wait_time:float = 1,execute:bool = false)->void:
	_is_ticking = true
	_wait_time = wait_time
	_total_time = 0.0
	_cur_time = wait_time if execute else 0

func stop()->void:
	_is_ticking = false
	_wait_time = 0
	_cur_time = 0
	_total_time = 0.0

func pause()->void:
	if is_stopped(): return
	_is_ticking = false

func resume()->void:
	if is_stopped(): return
	_is_ticking = true

func total_time()->float:
	return _total_time

func is_stopped()->bool:
	return _wait_time <= 0

func is_paused()->bool:
	return _wait_time > 0 and not _is_ticking

func is_ticking()->bool:
	return _wait_time > 0 and _is_ticking
