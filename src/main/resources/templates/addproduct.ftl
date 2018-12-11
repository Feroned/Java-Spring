<#import "parts/common.ftl" as c>

<@c.page "Add Product">
<div>
    <a href="/products">Back</a>
</div>
<div>
    <form method="post">
        <input type="text" name="name" placeholder="Enter name:">
        <input type="text" name="price" placeholder="Enter price:">
        <textarea name="shortDescription" placeholder="Enter short description:"></textarea>
        <br/>
        <b>Additional Info:</b>
        <br/>
        <textarea name="description" placeholder="Enter full product description:"></textarea>
        <select size="2" name="availability">
            <option value="0">No</option>
            <option value="1">Yes</option>
        </select>
        <input type="text" name="quantity">
        <button type="submit">Add Product</button>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    </form>
</div>
</@c.page>
