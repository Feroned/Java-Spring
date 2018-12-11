<#import "parts/common.ftl" as c>
<#import "parts/pager.ftl" as p>

<@c.page "Products">
<div>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <input type="submit" value="Sign Out"/>
    </form>
</div>
<div>
    <form action="/" method="get">
        <input type="submit" value="To Catalog"/>
    </form>
</div>
<div>
    <a href="/addProduct">Add New Product</a>
</div>
<form method="post" action="/deleteProducts">
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    <button type="submit">Delete</button>
<table>
<thead>
    <tr>
        <th></th>
        <th><b>ID</b></th>
        <th><b>Name</b></th>
        <th><b>Price</b></th>
        <th><b>Short Description</b></th>
        <th><b>Action</b></th>
    </tr>
    </thead>
<tbody>
<#list productEntities.content as productEntity>
    <tr>
        <td><input type="checkbox" name="id_${productEntity.id}" multiple value="${productEntity.id}"></td>
        <td>${productEntity.id}</td>
        <td>${productEntity.name}</td>
        <td>${productEntity.price}</td>
        <td>${productEntity.shortDescription}</td>
        <td><a href="/editProduct/${productEntity.id}">Edit</a></td>
    </tr>
<#else>
No products
</#list>
    </tbody>
</table>
<input type="hidden" name="_csrf" value="${_csrf.token}"/>
</form>
<@p.pager url, productEntities/>
</@c.page>