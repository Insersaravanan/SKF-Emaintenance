#pragma checksum "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Views\AuditLog\Index.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "f1b458749960ce93ecf1281d1430a31ff7d3d66a"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_AuditLog_Index), @"mvc.1.0.view", @"/Views/AuditLog/Index.cshtml")]
[assembly:global::Microsoft.AspNetCore.Mvc.Razor.Compilation.RazorViewAttribute(@"/Views/AuditLog/Index.cshtml", typeof(AspNetCore.Views_AuditLog_Index))]
namespace AspNetCore
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
#line 1 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Views\_ViewImports.cshtml"
using EMaintanance;

#line default
#line hidden
#line 2 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Views\_ViewImports.cshtml"
using EMaintanance.Models;

#line default
#line hidden
#line 1 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Views\AuditLog\Index.cshtml"
using Stimulsoft.Report.Web;

#line default
#line hidden
#line 2 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Views\AuditLog\Index.cshtml"
using Stimulsoft.Report.Mvc;

#line default
#line hidden
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"f1b458749960ce93ecf1281d1430a31ff7d3d66a", @"/Views/AuditLog/Index.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"0d99d051589a223aabf24b8387c074a6009fff84", @"/Views/_ViewImports.cshtml")]
    public class Views_AuditLog_Index : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<dynamic>
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            BeginContext(62, 2, true);
            WriteLiteral("\r\n");
            EndContext();
#line 4 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Views\AuditLog\Index.cshtml"
  
    ViewData["Title"] = "AuditLog - Viewer";
    Layout = "~/Views/Shared/_Layout.cshtml";

#line default
#line hidden
            BeginContext(164, 2, true);
            WriteLiteral("\r\n");
            EndContext();
            BeginContext(167, 254, false);
#line 9 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Views\AuditLog\Index.cshtml"
Write(Html.StiNetCoreViewer(new StiNetCoreViewerOptions()
{
    Actions =
    {
        GetReport = "GetReport",
        ViewerEvent = "ViewerEvent"
    },
    Toolbar =
    {
        ShowAboutButton = false,
        ShowOpenButton = false
    }
}));

#line default
#line hidden
            EndContext();
            BeginContext(421, 2, true);
            WriteLiteral("\r\n");
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
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<dynamic> Html { get; private set; }
    }
}
#pragma warning restore 1591
