(function (i, s, o, g, r, a, m) {
    i['GoogleAnalyticsObject'] = r;
    i[r] = i[r] || function () {
            (i[r].q = i[r].q || []).push(arguments)
        }, i[r].l = 1 * new Date();
    a = s.createElement(o),
        m = s.getElementsByTagName(o)[0];
    a.async = 1;
    a.src = g;
    m.parentNode.insertBefore(a, m)
})(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

$.getJSON("http://jsonip.com/?callback=?", function(data) {
    ga('create', 'UA-66980014-1', {
        'storage': 'none',
        'clientId': data.ip
    });
    ga('send', 'pageview');

    window.addEventListener('error', function (e) {
        ga('send', 'exception', {
            'exDescription': "Error message" + e.message + "\nFilename: " + e.filename + ": " + e.lineno
        })
    });
});