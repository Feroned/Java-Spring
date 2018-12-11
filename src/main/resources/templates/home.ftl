<#import "parts/common.ftl" as c>
<#import "parts/pager.ftl" as p>

<@c.page "Catalog">
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
            <p><a href="/view/${productEntity.id}">${productEntity.name}</a></p>
            <p>${productEntity.price}</p>
            <p>${productEntity.shortDescription}</p>
        </div>
</#list>
<@p.pager "", productEntities />
</@c.page>
