<#import "parts/common.ftl" as c>
<#import "parts/pager.ftl" as p>
<#import "parts/messages.ftl" as m>

<@c.page "Catalog" "catalog">
<div class="well bg-info">
        <a class="btn btn-primary" data-toggle="collapse" href="#collapseFilters" role="button" aria-expanded="false" aria-controls="collapseExample">
            Filters
        </a>
    <div class="btn-group collapse" id="collapseFilters">
        <form method="get" action="/catalog" class="form-inline">
            <input type="text" name="nameFilter" value="${nameFilter}" class="form-control mr-sm-2" placeholder="Name:">
            <input type="text" name="fromFilter" value="${fromFilter}" class="form-control mr-sm-2" placeholder="Price From:">
            <input type="text" name="toFilter" value="${toFilter}" class="form-control mr-sm-2"placeholder="Price To:">
            <label for="inputGroupSelect1">Order By: </label>
            <select name="order" class="custom-select ml-2" id="inputGroupSelect1">
                <option value="" <#if order == 0>selected</#if>></option>
                <option value="price" <#if order == 2>selected</#if>>Price</option>
                <option value="name" <#if order == 1>selected</#if>>Name</option>
            </select>
            <button type="submit" class="btn btn-primary ml-4">Find</button>
        </form>
    </div>
</div>
<@m.show show messageType message />
<div id="products" class="row">
    <#list productEntities.content as productEntity>
        <div class="item col-xs-4 col-lg-4">
        <div class="thumbnail">
        <#list productMedia as media>
            <#if media.getProductId() == productEntity.getId()>
            <a href="/view/${productEntity.id}">
                <img class="img-fluid" src="img/${media.getImgPath()}" alt="${media.getAltCode()}" width="250" height="400"/>
            </a>
            <#break>
            <#elseif !media_has_next>
            <a href="/view/${productEntity.id}">
                <img class="img-fluid" src="/img/placeholder.png" width="250" height="400"/>
            </a>
            </#if>
        <#else>
            <a href="/view/${productEntity.id}">
                <img class="img-fluid" src="/img/placeholder.png" width="250" height="400"/>
            </a>
        </#list>
            <div class="caption">
                <a href="/view/${productEntity.id}">
                    <h3 class="group list-group-item-heading">${productEntity.name}</h3>
                </a>
                <p class="group list-group-item-text">
                    ${productEntity.shortDescription}
                </p>
                <div class="row">
                    <div class="col-xs-12 col-md-6">
                        <p class="lead">$${productEntity.price}</p>
                    </div>
                    <div class="col-xs-12 col-md-6">
                        <a class="btn btn-primary w-75" href="/view/${productEntity.id}">View</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</#list>
</div>
<@p.pager "", productEntities />
</@c.page>