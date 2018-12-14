<#import "header.ftl" as h/>
<#import "carousel.ftl" as c/>
<#import "footer.ftl" as f/>

<#macro page title source = "">
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <#if source = "admin">
        <link rel="stylesheet" href="/static/css/authorization.css" />
    </#if>
    <#if source = "catalog">
        <link rel="stylesheet" href="/static/css/catalog.css">
        <link rel="stylesheet" href="/static/css/carousel.css">
        <link rel="stylesheet" href="/static/css/navbar.css">
    </#if>
    <#if source = "product">
        <link rel="stylesheet" href="/static/css/product.css">
        <link rel="stylesheet" href="/static/css/navbar.css">
    </#if>
    <#if source = "products">
        <link rel="stylesheet" href="/static/css/navbar.css">
        <link rel="stylesheet" href="/static/css/products.css">
    </#if>
    <#if source = "productActions">
        <link rel="stylesheet" href="/static/css/navbar.css">
        <link rel="stylesheet" href="/static/css/form.css">
    </#if>
    <title>${title}</title>
</head>
    <#if source = "admin">
        <body class="text-center">
    <#elseif source = "catalog">
    <body>
    <@h.header/>
    <@c.carousel/>
    <#else>
    <body>
    <@h.header/>
    </#if>
    <div class="container">
    <#nested>
    </div>
    <#if source != "admin">
        <@f.footer />
    </#if>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
</#macro>