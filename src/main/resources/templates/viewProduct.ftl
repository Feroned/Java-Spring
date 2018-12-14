<#import "parts/common.ftl" as c>
<#import  "parts/header.ftl" as h>

<@c.page "${productEntity.name}" "product">
    <div class="border bg-light pb-2 pl-2">
        <div class="row mt-2">
            <div class="col">
                <a class="btn btn-primary btn-lg active back-btn" role="button" aria-pressed="true" href="/catalog">Back</a>
            </div>
        </div>
        <div class="row mt-2 mb-2">
            <div class="col img-product">
            <div class="thumbnail"
                <a href="#" id="zoom" data-toggle="modal" data-target="#pictureFull">
                    <img id="image" src="/img/${productImage}" alt="${productAltCode}" width="400" height="250"/>
                </a>
            </div>
            <!-- Modal -->
            <div class="modal fade bd-example-modal-lg" id="pictureFull" tabindex="-1" role="dialog" aria-labelledby="pictureFull" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalCenterTitle">${productEntity.name}</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body text-center">
                            <img src="/img/${productImage}" id="preview"/>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary btn-lg" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            </div>
            <div class="col-6 d-flex align-items-start flex-column content">
                <div class="p-2 bd-highlight text-primary">
                    <h2><b>${productEntity.name}</b></h2>
                </div>
                <div class="mb-auto p-2 bd-highlight text-secondary">
                    <p><span>Price: </span>${productEntity.price}$</p>
                </div>
                <div>
                    <#if productData.availability == 1 && productData.quantity??>
                        <div class="text-success">In Stock</div>
                        <p class="text-secondary">Quantity: ${productData.quantity}</p>
                    <#else>
                        <div class="text-danger">Out Of Stock</div>
                    </#if>
                </div>
        </div>
        </div>
        <div class="row mt-4 justify-content-md-center">
            <div class="col-3">
                <a class="btn btn-primary btn-lg active" role="button" aria-pressed="true" href="/view/${links.prevProduct}">Prev</a>
            </div>
            <div class="col-rg-2">
                <a class="btn btn-primary btn-lg active" role="button" aria-pressed="true" href="/view/${links.nextProduct}">Next</a>
            </div>
        </div>
        </div>
    <section id="tabs" class="project-tab">
            <div class="row">
                <div class="col-md-12">
                    <nav>
                        <div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
                            <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Description</a>
                            <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Specification</a>
                            <#--<a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">Project Tab 3</a>-->
                        </div>
                    </nav>
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active bg-light mt-2" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                            <div class="ml-4 description text-secondary">
                                ${productData.description}
                            </div>
                        </div>
                        <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                            <table class="table table-striped" cellspacing="0">
                                <tbody>
                                <#if productData.showerType?? && productData.showerType != "">
                                <tr>
                                    <td>Shower Type:</td>
                                    <td>${productData.showerType}</td>
                                </tr>
                                </#if>
                                <#if productData.ceiling??>
                                    <tr>
                                    <td>Ceiling:</td>
                                    <td><#if productData.ceiling = 1>Yes<#else>No</#if></td>
                                    </tr>
                                </#if>
                                <#if productData.functions?? && productData.functions != "">
                                    <tr>
                                    <td>Functions:</td>
                                    <td>${productData.functions}</td>
                                    </tr>
                                </#if>
                                <#if productData.width?? && productData.height?? && productData.depth?? && productData.width != 0 && productData.height != 0 && productData.depth != 0>
                                    <tr>
                                    <td>Size, cm:</td>
                                    <td>${productData.width}x${productData.height}x${productData.depth}</td>
                                    </tr>
                                </#if>
                                <#if productData.pallet?? && productData.pallet == 1>
                                    <tr>
                                        <td>Pallet:</td>
                                        <td>With Pallet</td>
                                    </tr>
                                    <#if productData.palletHeight??>
                                        <tr>
                                        <td>Pallet Height, cm:</td>
                                        <td>${productData.palletHeight}</td>
                                        </tr>
                                    </#if>
                                    <#if productData.palletMaterial??>
                                        <tr>
                                        <td>Pallet Material:</td>
                                        <td>${productData.palletMaterial}</td>
                                        </tr>
                                    </#if>
                                    <#else>
                                    <tr>
                                        <td>With Pallet:</td>
                                        <td>No</td>
                                    </tr>
                                </#if>
                                <#if productData.curtainMaterial?? && productData.curtainMaterial != "">
                                    <tr>
                                    <td>Curtain Material:</td>
                                    <td>${productData.curtainMaterial}</td>
                                    </tr>
                                </#if>
                                <#if productData.glassType?? && productData.glassType != "">
                                    <tr>
                                    <td>Glass Type:</td>
                                    <td>${productData.glassType}</td>
                                    </tr>
                                </#if>
                                <#if productData.glassTickness?? && productData.glassTickness != 0>
                                    <tr>
                                    <td>Glass Tickness, mm:</td>
                                    <td>${productData.glassTickness}</td>
                                    </tr>
                                </#if>
                                <#if productData.doorConstruction?? && productData.doorConstruction != "">
                                    <tr>
                                    <td>Door Construction:</td>
                                    <td>${productData.doorConstruction}</td>
                                    </tr>
                                </#if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
    </section>
</@c.page>
