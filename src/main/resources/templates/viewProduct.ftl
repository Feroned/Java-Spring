<#import "parts/common.ftl" as c>

<@c.page "${productEntity.name}">
    <div>
        <a href="/">Back</a>
    </div>
    <div>
        <div>
            <p><b>${productEntity.name}</b></p>
        </div>
        <div>
            <p><span>Price: </span>${productEntity.price}$</p>
        </div>
        <p><b>Additional Info:</b></p>
        <div>
            <p>${productData.description}</p>
        </div>
        <div>
            <#if productData.availability == 1>
                <p>In Stock</p>
                <p><span>Quantity: </span>${productData.quantity}</p>
            <#else>
                <p>Out Of Stock</p>
            </#if>
        </div>
    </div>
</@c.page>
