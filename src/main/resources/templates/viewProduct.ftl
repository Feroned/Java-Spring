<#import "parts/common.ftl" as c>

<@c.page "${productEntity.name}">
    <div>
        <a href="/catalog">Back</a>
    </div>
    <div>
        <div>
            <p><b>${productEntity.name}</b></p>
        </div>
        <div>
            <img src="/img/${productImage}" alt="${productAltCode}"/>
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
    <a href="/view/${links.prevProduct}">Previous</a>
    <a href="/view/${links.nextProduct}">Next</a>
</@c.page>
