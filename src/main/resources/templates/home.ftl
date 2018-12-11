<#import "parts/common.ftl" as c>

<@c.page "Catalog">
<#list productEntities as productEntity>
        <div style="border: black 1px solid;">
            <p><a href="/view/${productEntity.id}">${productEntity.name}</a></p>
            <p>${productEntity.price}</p>
            <p>${productEntity.shortDescription}</p>
        </div>
</#list>
</@c.page>
