<#import "parts/common.ftl" as c>

<@c.page "Edit Product">
<div>
    <a href="/products">Back</a>
</div>
<div>
    <form method="post" action="/editProduct">
        <input type="text" name="name" placeholder="Enter name:" value="${productEntity.name}">
        <input type="text" name="price" placeholder="Enter price:" value="${productEntity.price}">
        <textarea name="shortDescription" placeholder="Enter short description:">${productEntity.shortDescription}</textarea>
        <br/>
        <b>Additional Info:</b>
        <br/>
        <textarea name="description" placeholder="Enter full product description:">${productData.description}</textarea>
        <#if productData.availability == 1>
            <label><input type="radio" name="availability" value="0"/>No</label>
            <label><input type="radio" name="availability" value="1" checked/>Yes</label>
        <#else>
            <label><input type="radio" name="availability" value="0" checked/>No</label>
            <label><input type="radio" name="availability" value="1" />Yes</label>
        </#if>
        <input type="text" name="quantity" value="${productData.quantity}">
        <button type="submit">Save</button>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <input type="hidden" name="id" value="${productEntity.id}"/>
    </form>
</div>
</@c.page>
