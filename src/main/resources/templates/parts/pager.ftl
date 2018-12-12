<#macro pager url page>
<div>
    <ul>
        <li>
            <a href="#">Pages: </a>
        </li>
        <#list 1..page.getTotalPages() as p>
        <#if (p - 1) == page.getNumber()>
            <li>
                <span>${p}</span>
            </li>
        <#else>
            <li>
                <a href="${url}?page=${p - 1}">${p}</a>
            </li>
        </#if>
        </#list>
    </ul>
</div>
</#macro>