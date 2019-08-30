$(document)['ready'](() => {
    function _0x3b8338(_0x4a90b9) {
        var _0x51fe42 = new jsSHA('SHA-256', 'TEXT');
        var _0x4e3a61 = _0x4a90b9['id'] + '\x20000\x20114328\x20000\x20' + _0x4a90b9['time'];
        _0x51fe42['update'](_0x4e3a61);
        var _0x50f900 = _0x51fe42['getHash']('HEX');
        return _0x50f900;
    }

    function _0x2b60c3(_0x1e5323) {
        var _0x1cedcf = Cookies['get']('time');
        var _0x496673 = Cookies['get']('id');
        if (_0x496673 == undefined || _0x1cedcf == undefined) _0x1e5323['failure']();
        else if (_0x496673 != $('#login-username')['val']()) _0x1e5323['failure']();
        else $['ajax']({
            'url': 'api/login/',
            'type': 'POST',
            'headers': {
                'X-Cache-Command': 'META',
                'X-Cache-User': _0x496673
            },
            'success': _0x3f2e31 => {
                var _0x57dd37 = new Date();
                if (_0x3f2e31['time'] != _0x1cedcf) _0x1e5323['failure']();
                else if (!_0x2f5261(_0x1cedcf, _0x57dd37)) _0x1e5323['failure']();
                else _0x1e5323['success']();
            }
        });
    }

    function _0x2f5261(_0x371199, _0x3e1987) {
        return !![];
    }

    function _0x374077() {
        _0x2b60c3({
            'success': _0x519e66,
            'failure': _0x3079b4
        });
    }

    function _0x519e66() {
        var _0x44a925 = Cookies['get']('id');
        var _0x24e669 = Cookies['get']('cck');
        $['ajax']({
            'url': 'api/login/',
            'type': 'POST',
            'headers': {
                'X-Cache-Command': 'PULL',
                'X-Cache-User': _0x44a925,
                'X-Cache-Key': _0x24e669
            },
            'success': _0xa48257 => {
                _0x2024b8(_0xa48257);
            },
            'error': () => {
                alert('Unexpected\x20Error!');
                Cookies['remove']('id');
                Cookies['remove']('cck');
                Cookies['remove']('time');
            }
        });
    }

    function _0x3079b4() {
        $['ajax']({
            'url': 'api/login/',
            'type': 'POST',
            'contentType': 'application/json;\x20charset=utf-8',
            'processData': ![],
            'data': JSON['stringify']({
                'password': $('#login-password')['val'](),
                'username': $('#login-username')['val']()
            }),
            'success': _0x30f7c5 => {
                _0x2024b8(_0x30f7c5);
                _0x3424b0(_0x30f7c5);
            },
            'error': _0x5194f8 => {
                if (_0x5194f8['status'] == 0x191) alert('Auth\x20Failed!');
                console['log'](_0x5194f8);
            }
        });
    }

    function _0x3424b0(_0x578481) {
        Cookies['set']('id', _0x578481['id']);
        Cookies['set']('time', _0x578481['time']);
        Cookies['set']('cck', _0x3b8338(_0x578481));
    }

    function _0x2024b8(_0x9b7d9e) {
        $('.page.login')['addClass']('hidden');
        $('.page.logged-in')['removeClass']('hidden');
        $('#login-message')['text'](_0x9b7d9e['data']);
    }
    $('#go-to-login')['click'](() => {
        $('.page.reg-success')['addClass']('hidden');
        $('.page.login')['removeClass']('hidden');
    });
    $('#logout')['click'](() => {
        $('.page.logged-in')['addClass']('hidden');
        $('.page.login')['removeClass']('hidden');
    });
    $('#register')['click'](() => {
        $('.page.login')['addClass']('hidden');
        $('.page.register')['removeClass']('hidden');
    });
    $('#login-re')['click'](() => {
        $('.page.register')['addClass']('hidden');
        $('.page.login')['removeClass']('hidden');
    });
    $('#registration-form')['submit'](_0x2692d6 => {
        _0x2692d6['preventDefault']();
        if ($('#reg-password')['val']() != $('#reg-again')['val']()) {
            alert('Passswords\x20Don\x27t\x20Match!');
            $('#reg-again')['val']('');
            return;
        }
        $['ajax']({
            'url': 'api/register/',
            'type': 'POST',
            'contentType': 'application/json;\x20charset=utf-8',
            'processData': ![],
            'data': JSON['stringify']({
                'password': $('#reg-password')['val']()
            }),
            'success': _0x3ddaa9 => {
                console['log'](_0x3ddaa9);
                $('.page.register')['addClass']('hidden');
                $('.page.reg-success')['removeClass']('hidden');
                $('#reg-message')['text'](_0x3ddaa9['id']);
            },
            'error': _0x3ca01f => {
                console['log'](_0x3ca01f);
            }
        });
    });
    $('#login-form')['submit'](_0x3b2693 => {
        _0x3b2693['preventDefault']();
        _0x374077();
    });
});
