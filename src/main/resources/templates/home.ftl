<#import "parts/common.ftl" as c>
<#import "parts/pager.ftl" as p>
<#import "parts/messages.ftl" as m>

<@c.page "Catalog">
<@m.show show messageType message />
    <div>
        <p><b>Filters:</b></p>
    </div>
    <form method="get" action="/catalog">
        <span>Name: </span><input type="text" name="nameFilter" value="${nameFilter}">
        <span>Price: </span><input type="text" name="fromFilter" value="${fromFilter}">
                            <input type="text" name="toFilter" value="${toFilter}">
        <span>Order By: </span>
    <select name="order">
        <option value="" <#if order == 0>selected</#if>></option>
        <option value="price" <#if order == 2>selected</#if>>Price</option>
        <option value="name" <#if order == 1>selected</#if>>Name</option>
    </select>
        <button type="submit">Find</button>
    </form>
<#list productEntities.content as productEntity>
        <div style="border: black 1px solid;">
    <#list productMedia as media>
        <#if media.getProductId() == productEntity.getId()>
            <a href="/view/${productEntity.id}"><img src="img/${media.getImgPath()}" alt="${media.getAltCode()}" width="100" height="100"/></a>
            <#break/>
        <#elseif !media_has_next>
            <a href="/view/${productEntity.id}"><img src="/img/placeholder.jpg" width="100" height="100"/></a>
        </#if>
    </#list>
            <p><a href="/view/${productEntity.id}">${productEntity.name}</a></p>
            <p>${productEntity.price}</p>
            <p>${productEntity.shortDescription}</p>
        </div>
</#list>
<@p.pager "", productEntities />
</@c.page>
