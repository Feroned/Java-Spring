<#macro productActions edit=false title="">
<#import "common.ftl" as c>
<#import "messages.ftl" as m>

<@c.page title "productActions">
<@m.show show messageType message />
    <div class="row justify-content-center align-items-center text-primary">
        <h1 class="display-3"><#if edit = true>${productEntity.name} <#else>Add New Product</#if></h1>
    </div>
    <div class="row mt-2">
        <div class="col-md-2">
            <a class="btn btn-primary btn-block" href="/products">Back</a>
        </div>
        <div class="col"></div>
        <div class="col-md-2">
            <button class="btn btn-warning btn-block" form="productAdd" type="submit"><#if edit = true>Save<#else>Add Product</#if></button>
        </div>
    </div>
    <form class="needs-validation" <#if edit =true>action="/editProduct/${productEntity.id}"</#if> id="productAdd" method="post" enctype="multipart/form-data" novalidate>
        <section id="tabs" class="project-tab">
            <div class="row">
                <div class="col-md-12">
                    <nav>
                        <div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
                            <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Required Attributes</a>
                            <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Options</a>
                            <#--<a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">Project Tab 3</a>-->
                        </div>
                    </nav>
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active bg-light mt-2 pl-4" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                            <div class="form-row mt-2">
                                <div class="col-md-6 mb-3">
                                    <label for="name">Product Name:</label>
                                    <input type="text" <#if edit = true>value="${productEntity.name}"</#if> class="form-control" id="name" name="name" placeholder="Name:" required>
                                    <div class="invalid-feedback">
                                        Please provide a valid product name.
                                    </div>
                                </div>
                            </div>
                            <div class="form-row mt-2">
                                <div class="col-md-6 mb-3">
                                    <label for="price">Price:</label>
                                    <input type="text" <#if edit = true>value="${productEntity.price}"</#if> class="form-control w-50" id="price" name="priceStr" placeholder="Price:" required>
                                    <div class="invalid-feedback">
                                        Please provide a valid price.
                                    </div>
                                </div>
                            </div>
                            <div class="form-row mt-2">
                                <div class="col-md-6 mb-3">
                                    <label for="shortDescription">Short Description:</label>
                                    <textarea class="form-control" rows="4" id="shortDescription" name="shortDescription" placeholder="Enter short description:" required><#if edit = true>${productEntity.shortDescription}</#if></textarea>
                                    <div class="invalid-feedback">
                                        Please enter a description of product.
                                    </div>
                                </div>
                            </div>
                            <div class="form-row mt-2">
                                <div class="col-md-6 mb-3">
                                    <label for="availability">In Stock:</label>
                                    <select class="form-control w-25" name="availability" id="availability" required>
                                        <#if edit = true>
                                            <#if productData.availability == 1>
                                                <option value="1">Yes</option>
                                                <option value="0" >No</option>
                                            <#else>
                                                <option value="0">No</option>
                                                <option value="1">Yes</option>
                                            </#if>
                                        <#else>
                                            <option value="0">No</option>
                                            <option value="1">Yes</option>
                                        </#if>

                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade bg-light pl-4" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                            <div class="form-row mt-2">
                                <div class="col-md-6 mb-3">
                                    <label for="description">Description:</label>
                                    <textarea class="form-control" rows="4" id="description" name="description" placeholder="Enter description:"><#if edit = true>${productData.description}</#if></textarea>
                                </div>
                            </div>
                            <div class="form-row mt-2">
                                <div class="col-md-6 mb-3">
                                    <label for="quantity">Quantity:</label>
                                    <input type="text" <#if edit = true>value="${productData.quantity}"</#if> class="form-control w-50" id="quantity" name="quantityStr" placeholder="Quantity:">
                                </div>
                            </div>
                            <#if edit = true>
                                <div class="form-row mt-2">
                                     <div class="col-md-6 mb-3">
                                        <img src="/img/${productImage}" alt="${productAltCode}"/>
                                    </div>
                                </div>
                            </#if>
                            <div class="form-row mt-2">
                                <div class="col-md-6 mb-3">
                                    <label class="custom-file-label w-50" for="file">Choose product picture...</label>
                                    <input class="custom-file-input w-25" type="file" id="file" name="productImage">
                                </div>
                            </div>
                            <div class="form-row mt-2">
                                <div class="col-md-6 mb-3">
                                    <label for="quantity">Shower Type:</label>
                                    <input type="text" <#if edit = true && productData.showerType?? >value="${productData.showerType}"</#if> class="form-control w-50" id="showerType" name="showerType" placeholder="Shower Type:">
                                </div>
                            </div>
                            <div class="form-row mt-2">
                                <div class="col-md-6 mb-3">
                                    <label for="pallet">Ceilinig:</label>
                                    <select class="form-control w-25" name="ceiling" id="ceiling" required>
                                        <#if edit = true>
                                            <#if productData.ceiling?? && productData.ceiling == 1>
                                                <option value="1">Yes</option>
                                                <option value="0" >No</option>
                                            <#else>
                                                <option value="0">No</option>
                                                <option value="1">Yes</option>
                                            </#if>
                                        <#else>
                                            <option value="0">No</option>
                                            <option value="1">Yes</option>
                                        </#if>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row mt-2">
                                <div class="col-md-6 mb-3">
                                    <label for="description">Functions:</label>
                                    <textarea class="form-control" rows="4" id="functions" name="functions" placeholder="Functions:" aria-describedby="functionsHelpBlock"><#if edit = true && productData.functions??>${productData.functions}</#if></textarea>
                                    <small id="functionsHelpBlock" class="form-text text-muted">
                                        Enter each function from a new line.
                                    </small>
                                </div>
                            </div>
                            <div class="form-row mt-2">
                                <div class="col-md-6 mb-3">
                                    <label for="width">Sizes, cm:</label>
                                    <input type="text" <#if edit = true && productData.width??>value="${productData.width}"</#if> class="form-control w-25" id="width" name="widthStr" placeholder="Width:"><span class="text-secondary">X</span>
                                    <input type="text" <#if edit = true && productData.height??>value="${productData.height}"</#if> class="form-control w-25" id="height" name="heightStr" placeholder="Height:"><span class="text-secondary">X</span>
                                    <input type="text" <#if edit = true && productData.depth??>value="${productData.depth}"</#if> class="form-control w-25" id="depth" name="depthStr" placeholder="Depth:"><span class="text-secondary">X</span>
                                </div>
                            </div>
                            <div class="form-row mt-2">
                                <div class="col-md-6 mb-3">
                                    <label for="pallet">Pallet:</label>
                                    <select class="form-control w-25" name="pallet" id="pallet" required>
                                        <#if edit = true>
                                            <#if productData.pallet?? && productData.pallet == 1>
                                                <option value="1">Yes</option>
                                                <option value="0" >No</option>
                                            <#else>
                                                <option value="0">No</option>
                                                <option value="1">Yes</option>
                                            </#if>
                                        <#else>
                                            <option value="1">Yes</option>
                                            <option value="0">No</option>
                                        </#if>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row mt-2">
                                <div class="col-md-6 mb-3">
                                    <label for="palletMaterial">Pallet Material:</label>
                                    <input type="text" <#if edit = true && productData.palletMaterial??>value="${productData.palletMaterial}"</#if> class="form-control w-50" id="palletMaterial" name="palletMaterial" placeholder="Pallet Material:">
                                </div>
                            </div>
                            <div class="form-row mt-2">
                                <div class="col-md-6 mb-3">
                                    <label for="palletHeight">Pallet Height:</label>
                                    <input type="text" <#if edit = true && productData.palletHeight??>value="${productData.palletHeight}"</#if> class="form-control w-25" id="palletHeight" name="palletHeightStr" placeholder="Pallet Height:">
                                </div>
                            </div>
                            <div class="form-row mt-2">
                                <div class="col-md-6 mb-3">
                                    <label for="curtainMaterial">Curtain Maeterial:</label>
                                    <input type="text" <#if edit = true && productData.curtainMaterial??>value="${productData.curtainMaterial}"</#if> class="form-control w-50" id="curtainMaterial" name="curtainMaterial" placeholder="Curtain Material:">
                                </div>
                            </div>
                            <div class="form-row mt-2">
                                <div class="col-md-6 mb-3">
                                    <label for="glassType">Glass Type:</label>
                                    <input type="text" <#if edit = true && productData.glassType??>value="${productData.glassType}"</#if> class="form-control w-50" id="glassType" name="glassType" placeholder="Glass Type:">
                                </div>
                            </div>
                            <div class="form-row mt-2">
                                <div class="col-md-6 mb-3">
                                    <label for="glassTickness">Glass Tickness, cm:</label>
                                    <input type="text" <#if edit = true && productData.glassTickness??>value="${productData.glassTickness}"</#if> class="form-control w-25" id="glassTickness" name="glassTicknessStr" placeholder="Glass Tickness:">
                                </div>
                            </div>
                            <div class="form-row mt-2">
                                <div class="col-md-6 mb-3">
                                    <label for="doorConstruction">Door Construction:</label>
                                    <input type="text" <#if edit = true && productData.doorConstruction??>value="${productData.doorConstruction}"</#if> class="form-control w-50" id="doorConstruction" name="doorConstruction" placeholder="Door Construction:">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    </form>
    <script>
        (function() {
            'use strict';
            window.addEventListener('load', function() {
                var forms = document.getElementsByClassName('needs-validation');
                // Loop over them and prevent submission
                var validation = Array.prototype.filter.call(forms, function(form) {
                    form.addEventListener('submit', function(event) {
                        if (form.checkValidity() === false) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        var digits = document.getElementById("price").value;
                        var myRe = /^\d+$/gm;
                        if (!digits && myRe.exec(digits) === null) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            }, false);
        })();
    </script>
    </@c.page>

</#macro>