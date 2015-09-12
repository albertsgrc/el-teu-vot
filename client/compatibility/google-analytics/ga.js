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

ga('create', 'UA-66980014-1', {
    'storage': 'none',
    'clientId': Random.id()
});

ga('send', 'pageview');

function trackJavaScriptError(e) {
    var ie = window.event || {},
        errMsg = e.message || ie.errorMessage;
    var errSrc = (e.filename || ie.errorUrl) + ': ' + (e.lineno || ie.errorLine);
    ga('send', 'event', 'JavaScript Error', errMsg, errSrc, { 'nonInteraction': 1 });
}


if (window.addEventListener) {
    window.addEventListener('error', trackJavaScriptError, false);
} else if (window.attachEvent) {
    window.attachEvent('onerror', trackJavaScriptError);
} else {
    window.onerror = trackJavaScriptError;
}