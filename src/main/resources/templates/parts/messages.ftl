<#macro show show=false type=0 message="">
    <div >
    <#if show == true>
        <#if type = 0>
            <div class="alert alert-success" role="alert"><b>${message}</b></div>
        <#else>
            <div class="alert alert-danger" role="alert"><b>${message}</b></div>
        </#if>
    </#if>
    </div>
</#macro>