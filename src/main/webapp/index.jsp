<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Webapp with RESTful Service</title>
    <%-- http://stackoverflow.com/questions/4764405/how-to-use-relative-paths-without-including-the-context-root-name --%>
    <base href="${pageContext.request.contextPath}/">
</head>
<body>
<h1>Webapp with RESTful Service</h1>
<a href="api/hello">Call API</a>
</body>
</html>