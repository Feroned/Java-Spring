<#import "parts/common.ftl" as c>
<#import "parts/messages.ftl" as m>
<@c.page "Admin" "admin">
        <div class="row h-100 justify-content-center align-items-center">
            <div class="col-6">
                <form class="form-horizontal" method="post" action="/admin">
                    <span class="heading">Admin panel</span>
                     <@m.show show messageType message />
                    <div class="form-group">
                        <input type="text" class="form-control" id="inputText" placeholder="E-mail" name="username">
                        <i class="fa fa-user"></i>
                    </div>
                    <div class="form-group help">
                        <input type="password" class="form-control" id="inputPassword" placeholder="Password" name="password">
                        <i class="fa fa-lock"></i>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-default">Sign In</button>
                    </div>
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                </form>
            </div>
        </div>
</@c.page>