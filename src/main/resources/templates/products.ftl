<#import "parts/common.ftl" as c>
<#import "parts/pager.ftl" as p>
<#import "parts/messages.ftl" as m>


<@c.page "Products" "products">
<@m.show show messageType message />

<div class="row justify-content-center align-items-center">
    <div class="btn-group" role="group" aria-label="Basic example">
        <input class="btn btn-warning" type="submit" value="Sign Out" form="logout"/>
        <input class="btn btn-info" type="submit" value="To Catalog" form="catalog"/>
    </div>
    <form action="/logout" method="post" id="logout">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    </form>
    <form action="/" method="get" id="catalog">
    </form>
</div>
<div class="row mb-1">
    <div class="col">
        <button class="btn btn-danger btn-lg delete-button" type="submit" form="delete">Delete</button>
    </div>
    <div class="col">
        <a class="btn btn-primary btn-lg float-right add-button" href="/addProduct">Add New Product</a>
    </div>
</div>
<form method="post" action="/deleteProducts" id="delete">
<table class="table table-stripped">
<thead class="thead-dark">
    <tr>
        <th scope="col">#</th>
        <th scope="col"><a href="/products?sort=id">ID</a></th>
        <th scope="col">Thubmnail</th>
        <th scope="col"><a href="/products?sort=name">Name</a></th>
        <th scope="col"><a href="/products?sort=price">Price</a></th>
        <th scope="col">Short Description</th>
        <th scope="col">Action</th>
    </tr>
    </thead>
<tbody class="bg-light">
<#list productEntities.content as productEntity>
    <tr>
    <td><input type="checkbox" name="id_${productEntity.id}" multiple value="${productEntity.id}"></td>
    <td>${productEntity.id}</td>
    <#list productMedia as media>
            <#if media.getProductId() == productEntity.getId()>
                <td><img src="img/${media.getImgPath()}" alt="${media.getAltCode()}" width="90" height="60"/></td>
                <#break/>
            <#elseif !media_has_next>
                    <td><img src="/img/placeholder.png" width="90" height="60"/> </td>
            </#if>
        <#else>
            <td><img src="/img/placeholder.png" width="90" height="60"/> </td>
        </#list>
        <td class="font-weight-bold">${productEntity.name}</td>
        <td>$${productEntity.price}</td>
        <td class="text-secondary">${productEntity.shortDescription}</td>
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