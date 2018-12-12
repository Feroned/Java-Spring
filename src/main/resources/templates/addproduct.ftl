<#import "parts/common.ftl" as c>
<#import "parts/messages.ftl" as m>

<@c.page "Add Product">
<@m.show show messageType message />
<div>
    <a href="/products">Back</a>
</div>
<div>
    <form method="post" enctype="multipart/form-data">
        <input type="text" name="name" placeholder="Enter name:">
        <input type="text" name="priceStr" placeholder="Enter price:">
        <textarea name="shortDescription" placeholder="Enter short description:"></textarea>
        <br/>
        <b>Additional Info:</b>
        <br/>
        <textarea name="description" placeholder="Enter full product description:"></textarea>
        <select name="availability">
            <option value="0">No</option>
            <option value="1">Yes</option>
        </select>
        <input type="text" name="quantityStr">
        <input type="file" name="productImage">
        <button type="submit">Add Product</button>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    </form>
</div>
</@c.page>
