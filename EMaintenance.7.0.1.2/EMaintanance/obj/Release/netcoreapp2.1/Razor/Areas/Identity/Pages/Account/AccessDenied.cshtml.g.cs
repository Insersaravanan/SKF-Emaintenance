#pragma checksum "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Areas\Identity\Pages\Account\AccessDenied.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "20cb16eee4d78b30d8537ea0515474fe169baced"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(EMaintanance.Areas.Identity.Pages.Account.Areas_Identity_Pages_Account_AccessDenied), @"mvc.1.0.razor-page", @"/Areas/Identity/Pages/Account/AccessDenied.cshtml")]
[assembly:global::Microsoft.AspNetCore.Mvc.RazorPages.Infrastructure.RazorPageAttribute(@"/Areas/Identity/Pages/Account/AccessDenied.cshtml", typeof(EMaintanance.Areas.Identity.Pages.Account.Areas_Identity_Pages_Account_AccessDenied), null)]
namespace EMaintanance.Areas.Identity.Pages.Account
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
#line 1 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Areas\Identity\Pages\_ViewImports.cshtml"
using Microsoft.AspNetCore.Identity;

#line default
#line hidden
#line 2 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Areas\Identity\Pages\_ViewImports.cshtml"
using EMaintanance.Areas.Identity;

#line default
#line hidden
#line 1 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Areas\Identity\Pages\Account\_ViewImports.cshtml"
using EMaintanance.Areas.Identity.Pages.Account;

#line default
#line hidden
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"20cb16eee4d78b30d8537ea0515474fe169baced", @"/Areas/Identity/Pages/Account/AccessDenied.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"6879ca5c9df988f55b626756faa3cca6b29c7f9f", @"/Areas/Identity/Pages/_ViewImports.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"b04ec060273dc867686bcb739410a0873531a3fd", @"/Areas/Identity/Pages/Account/_ViewImports.cshtml")]
    public class Areas_Identity_Pages_Account_AccessDenied : global::Microsoft.AspNetCore.Mvc.RazorPages.Page
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
#line 3 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Areas\Identity\Pages\Account\AccessDenied.cshtml"
  
    ViewData["Title"] = "Access denied";

#line default
#line hidden
            BeginContext(82, 99, true);
            WriteLiteral("<div class=\"container-fluid text-center\">\r\n    <div class=\"well\">\r\n        <h1 class=\"text-danger\">");
            EndContext();
            BeginContext(182, 17, false);
#line 8 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Areas\Identity\Pages\Account\AccessDenied.cshtml"
                           Write(ViewData["Title"]);

#line default
#line hidden
            EndContext();
            BeginContext(199, 200, true);
            WriteLiteral("</h1>\r\n        <p class=\"text-danger\">You do not have access to this resource.</p>\r\n        <p>\r\n            <a href=\"/\" class=\"btn btn-primary\">Back to Home Page</a>\r\n        </p>\r\n    </div>\r\n</div>");
            EndContext();
        }
        #pragma warning restore 1998
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<AccessDeniedModel> Html { get; private set; }
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.ViewDataDictionary<AccessDeniedModel> ViewData => (global::Microsoft.AspNetCore.Mvc.ViewFeatures.ViewDataDictionary<AccessDeniedModel>)PageContext?.ViewData;
        public AccessDeniedModel Model => ViewData.Model;
    }
}
#pragma warning restore 1591
