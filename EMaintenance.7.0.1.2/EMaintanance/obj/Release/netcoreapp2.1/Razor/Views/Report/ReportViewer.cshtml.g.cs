#pragma checksum "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Views\Report\ReportViewer.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "27ccc7b37e4ccd0d95b1de119612a19a0b85fbf5"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Report_ReportViewer), @"mvc.1.0.view", @"/Views/Report/ReportViewer.cshtml")]
[assembly:global::Microsoft.AspNetCore.Mvc.Razor.Compilation.RazorViewAttribute(@"/Views/Report/ReportViewer.cshtml", typeof(AspNetCore.Views_Report_ReportViewer))]
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
#line 2 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Views\Report\ReportViewer.cshtml"
using AlanJuden.MvcReportViewer;

#line default
#line hidden
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"27ccc7b37e4ccd0d95b1de119612a19a0b85fbf5", @"/Views/Report/ReportViewer.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"0d99d051589a223aabf24b8387c074a6009fff84", @"/Views/_ViewImports.cshtml")]
    public class Views_Report_ReportViewer : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<AlanJuden.MvcReportViewer.ReportViewerModel>
    {
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_0 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("href", new global::Microsoft.AspNetCore.Html.HtmlString("~/lib/jquery-ui/jquery-ui.min.css"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_1 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("rel", new global::Microsoft.AspNetCore.Html.HtmlString("stylesheet"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_2 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("type", new global::Microsoft.AspNetCore.Html.HtmlString("text/css"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_3 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("href", new global::Microsoft.AspNetCore.Html.HtmlString("~/css/mvcreportviewer-bootstrap.css"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_4 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("type", new global::Microsoft.AspNetCore.Html.HtmlString("text/javascript"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_5 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("src", new global::Microsoft.AspNetCore.Html.HtmlString("~/lib/jquery/dist/jquery.min.js"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_6 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("href", new global::Microsoft.AspNetCore.Html.HtmlString("~/lib/bootstrap-multiselect/bootstrap-multiselect.css"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_7 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("src", new global::Microsoft.AspNetCore.Html.HtmlString("~/lib/bootstrap-multiselect/bootstrap-multiselect.js"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_8 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("src", new global::Microsoft.AspNetCore.Html.HtmlString("~/lib/jquery.highlight-5.js"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_9 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("src", new global::Microsoft.AspNetCore.Html.HtmlString("~/lib/jquery-ui/jquery-ui.min.js"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        #line hidden
        #pragma warning disable 0169
        private string __tagHelperStringValueBuffer;
        #pragma warning restore 0169
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperExecutionContext __tagHelperExecutionContext;
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner __tagHelperRunner = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner();
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __backed__tagHelperScopeManager = null;
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __tagHelperScopeManager
        {
            get
            {
                if (__backed__tagHelperScopeManager == null)
                {
                    __backed__tagHelperScopeManager = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager(StartTagHelperWritingScope, EndTagHelperWritingScope);
                }
                return __backed__tagHelperScopeManager;
            }
        }
        private global::Microsoft.AspNetCore.Mvc.Razor.TagHelpers.UrlResolutionTagHelper __Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper;
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            BeginContext(86, 2, true);
            WriteLiteral("\r\n");
            EndContext();
#line 4 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Views\Report\ReportViewer.cshtml"
  
    ViewBag.Title = "ReportViewer";
    Layout = "~/Views/Shared/_Layout.cshtml";

#line default
#line hidden
            BeginContext(179, 2, true);
            WriteLiteral("\r\n");
            EndContext();
            DefineSection("AdditionalHeadContent", async() => {
                BeginContext(213, 6, true);
                WriteLiteral("\r\n    ");
                EndContext();
                BeginContext(219, 66, false);
                __tagHelperExecutionContext = __tagHelperScopeManager.Begin("link", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.SelfClosing, "c6f4729f9d49428ab2501881e6558fb8", async() => {
                }
                );
                __Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.Razor.TagHelpers.UrlResolutionTagHelper>();
                __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper);
                __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_0);
                __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_1);
                await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
                if (!__tagHelperExecutionContext.Output.IsContentModified)
                {
                    await __tagHelperExecutionContext.SetOutputContentAsync();
                }
                Write(__tagHelperExecutionContext.Output);
                __tagHelperExecutionContext = __tagHelperScopeManager.End();
                EndContext();
                BeginContext(285, 6, true);
                WriteLiteral("\r\n    ");
                EndContext();
                BeginContext(291, 84, false);
                __tagHelperExecutionContext = __tagHelperScopeManager.Begin("link", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.SelfClosing, "3d85a1d57a964a2aafd9990fbcffc668", async() => {
                }
                );
                __Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.Razor.TagHelpers.UrlResolutionTagHelper>();
                __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper);
                __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_2);
                __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_1);
                __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_3);
                await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
                if (!__tagHelperExecutionContext.Output.IsContentModified)
                {
                    await __tagHelperExecutionContext.SetOutputContentAsync();
                }
                Write(__tagHelperExecutionContext.Output);
                __tagHelperExecutionContext = __tagHelperScopeManager.End();
                EndContext();
                BeginContext(375, 6, true);
                WriteLiteral("\r\n    ");
                EndContext();
                BeginContext(381, 78, false);
                __tagHelperExecutionContext = __tagHelperScopeManager.Begin("script", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "b2f35ab8433d4e14adc8e31d3f84d232", async() => {
                }
                );
                __Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.Razor.TagHelpers.UrlResolutionTagHelper>();
                __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper);
                __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_4);
                __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_5);
                await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
                if (!__tagHelperExecutionContext.Output.IsContentModified)
                {
                    await __tagHelperExecutionContext.SetOutputContentAsync();
                }
                Write(__tagHelperExecutionContext.Output);
                __tagHelperExecutionContext = __tagHelperScopeManager.End();
                EndContext();
                BeginContext(459, 6, true);
                WriteLiteral("\r\n    ");
                EndContext();
                BeginContext(465, 86, false);
                __tagHelperExecutionContext = __tagHelperScopeManager.Begin("link", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.SelfClosing, "72c9d90ab1b64f2e9dd2ce5a915b6fb2", async() => {
                }
                );
                __Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.Razor.TagHelpers.UrlResolutionTagHelper>();
                __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper);
                __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_6);
                __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_1);
                await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
                if (!__tagHelperExecutionContext.Output.IsContentModified)
                {
                    await __tagHelperExecutionContext.SetOutputContentAsync();
                }
                Write(__tagHelperExecutionContext.Output);
                __tagHelperExecutionContext = __tagHelperScopeManager.End();
                EndContext();
                BeginContext(551, 6, true);
                WriteLiteral("\r\n    ");
                EndContext();
                BeginContext(557, 76, false);
                __tagHelperExecutionContext = __tagHelperScopeManager.Begin("script", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "2e9e317fdc924f2eae542b18803be065", async() => {
                }
                );
                __Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.Razor.TagHelpers.UrlResolutionTagHelper>();
                __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper);
                __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_7);
                await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
                if (!__tagHelperExecutionContext.Output.IsContentModified)
                {
                    await __tagHelperExecutionContext.SetOutputContentAsync();
                }
                Write(__tagHelperExecutionContext.Output);
                __tagHelperExecutionContext = __tagHelperScopeManager.End();
                EndContext();
                BeginContext(633, 6, true);
                WriteLiteral("\r\n    ");
                EndContext();
                BeginContext(639, 74, false);
                __tagHelperExecutionContext = __tagHelperScopeManager.Begin("script", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "224635bc18bf49889f8bca12c24ceba9", async() => {
                }
                );
                __Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.Razor.TagHelpers.UrlResolutionTagHelper>();
                __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper);
                __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_4);
                __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_8);
                await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
                if (!__tagHelperExecutionContext.Output.IsContentModified)
                {
                    await __tagHelperExecutionContext.SetOutputContentAsync();
                }
                Write(__tagHelperExecutionContext.Output);
                __tagHelperExecutionContext = __tagHelperScopeManager.End();
                EndContext();
                BeginContext(713, 6, true);
                WriteLiteral("\r\n    ");
                EndContext();
                BeginContext(719, 56, false);
                __tagHelperExecutionContext = __tagHelperScopeManager.Begin("script", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "3cc80cc16e4142fdb505384c0d8e4b28", async() => {
                }
                );
                __Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.Razor.TagHelpers.UrlResolutionTagHelper>();
                __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper);
                __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_9);
                await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
                if (!__tagHelperExecutionContext.Output.IsContentModified)
                {
                    await __tagHelperExecutionContext.SetOutputContentAsync();
                }
                Write(__tagHelperExecutionContext.Output);
                __tagHelperExecutionContext = __tagHelperScopeManager.End();
                EndContext();
                BeginContext(775, 287, true);
                WriteLiteral(@"


    <script type=""text/javascript"">
			$(document).ready(function () {
                _initializeReportViewerControls();

                 //To style and input customization
                $('#frmReportViewer').prepend('<div class=""content-heading-pane""><span class=""title"">");
                EndContext();
                BeginContext(1063, 18, false);
#line 24 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Views\Report\ReportViewer.cshtml"
                                                                                                Write(ViewData["report"]);

#line default
#line hidden
                EndContext();
                BeginContext(1081, 2510, true);
                WriteLiteral(@"</span><div class=""back-to-list""><a class=""btn btn-info"" href= ""/report""><i class=""fa fa-times""></i>Cancel</a></div></div>');


				$('.FirstPage, .ViewReport, .Refresh').click(function () {
					if (!$(this).attr('disabled')) {
						viewReportPage(1);
					}
                });

                $("".ViewReport"").trigger('click');


				$('.PreviousPage').click(function () {
					if (!$(this).attr('disabled')) {
						var page = parseInt($('#ReportViewerCurrentPage').val()) - 1;

						viewReportPage(page);
					}
				});

				$('.NextPage').click(function () {
					if (!$(this).attr('disabled')) {
						var page = parseInt($('#ReportViewerCurrentPage').val()) + 1;

						viewReportPage(page);
					}
				});

				$('.LastPage').click(function () {
					if (!$(this).attr('disabled')) {
						var page = parseInt($('#ReportViewerTotalPages').text());

						viewReportPage(page);
					}
				});

				$('#ReportViewerCurrentPage').change(function () {
					var page = $(this).val");
                WriteLiteral(@"();

					viewReportPage(page);
				});

				$('.ExportXml, .ExportCsv, .ExportPdf, .ExportMhtml, .ExportExcelOpenXml, .ExportTiff, .ExportWordOpenXml').click(function () {
					exportReport($(this));
				});

				$('#ReportViewerSearchText').on(""keypress"", function (e) {
					if (e.keyCode == 13) {
						// Cancel the default action on keypress event
						e.preventDefault();
						findText();
					}
				});

				$('.FindTextButton').click(function () {
					findText();
				});

				$('.Print').click(function () {
					printReport();
                });

                reloadParameters();
			});

			function _initializeReportViewerControls() {
				 //$('select').select2();
                //$('select > option').prop(""selected"", true).trigger(""change"");
                $(""select"").multiselect({
                    includeSelectAllOption: true,
                    allSelectedText: 'All Selected'
                    });

                $('input[type=""datetime""]').attr({ 'ty");
                WriteLiteral(@"pe': 'text', 'placeholder': 'mm-dd-yyyy'}).datepicker({
                    dateFormat: ""mm-dd-yy""
                });

                try {
					ReportViewer_Register_OnChanges();
				} catch (e) { }
			}

			function reloadParameters() {
				var params = $('.ParametersContainer :input').serializeArray();
				var urlParams = $.param(params);

				showLoadingProgress(""Updating Parameters..."");

				$.get(""/Report/ReloadParameters/?reportPath=");
                EndContext();
                BeginContext(3592, 28, false);
#line 112 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Views\Report\ReportViewer.cshtml"
                                                       Write(Model.ReportPath.UrlEncode());

#line default
#line hidden
                EndContext();
                BeginContext(3620, 1545, true);
                WriteLiteral(@"&"" + urlParams).done(function (data) {
					if (data != null) {
						$('.Parameters').html(data);
						_initializeReportViewerControls();

						//if ($('.ReportViewerContent').find('div').length != 1) {
						//	$('.ReportViewerContent').html('<div class=""ReportViewerInformation"">Please fill parameters and run the report...</div>');
						//}
					}
					hideLoadingProgress();
				});
			}

			function showLoadingProgress(message) {
				hideLoadingProgress();

				$('.ReportViewerContent').hide();
				$('.ReportViewerContentContainer').append('<div class=""loadingContainer""><div style=""margin: 0 auto; width: 100%; text-align: center; vertical-align: middle;""><h2><i class=""glyphicon glyphicon-refresh gly-spin""></i>' + message + '</h2></div></div>');
			}

			function hideLoadingProgress() {
				$('.loadingContainer').remove();
				$('.ReportViewerContent').show();
			}

			function printReport() {
				var params = $('.ParametersContainer :input').serializeArray();
                v");
                WriteLiteral(@"ar urlParams = $.param(params);
                var innerContents = document.getElementById(""oReportCell"").innerHTML;
                var popupWinindow = window.open('', '_blank', 'width=950,height=600,scrollbars=no,menubar=no,toolbar=no,location=no,status=no,titlebar=no');

                popupWinindow.document.write('<html><head><link rel=""stylesheet"" type=""text/css"" href=""/css/site.css"" /></head><body onload=""window.print()"">' + innerContents + '</html>');
				//window.open(""/Report/PrintReport/?reportPath=");
                EndContext();
                BeginContext(5166, 28, false);
#line 144 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Views\Report\ReportViewer.cshtml"
                                                          Write(Model.ReportPath.UrlEncode());

#line default
#line hidden
                EndContext();
                BeginContext(5194, 576, true);
                WriteLiteral(@"&"" + urlParams, ""_self"");
                popupWinindow.document.close();

			}

			function findText() {
				$('.ReportViewerContent').removeHighlight();
				var searchText = $(""#ReportViewerSearchText"").val();
				if (searchText != undefined && searchText != null && searchText != """") {
					showLoadingProgress('Searching Report...');
					var params = $('.ParametersContainer :input').serializeArray();
					var urlParams = $.param(params);

					var page = parseInt($('#ReportViewerCurrentPage').val());

					$.get(""/Report/FindStringInReport/?reportPath=");
                EndContext();
                BeginContext(5771, 28, false);
#line 159 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Views\Report\ReportViewer.cshtml"
                                                             Write(Model.ReportPath.UrlEncode());

#line default
#line hidden
                EndContext();
                BeginContext(5799, 878, true);
                WriteLiteral(@"&page="" + page + ""&searchText="" + searchText + ""&"" + urlParams).done(function (data) {
						if (data > 0) {
							viewReportPage(data, function () {
								$('.ReportViewerContent').highlight(searchText);
								hideLoadingProgress();
							});
						} else {
							$('.ReportViewerContent').highlight(searchText);
							hideLoadingProgress();
						}
					});
				}
			}

			function viewReportPage(page, afterReportLoadedCallback) {
				showLoadingProgress('Loading Report Page...');
				var params = $('.ParametersContainer :input').serializeArray();
				var urlParams = $.param(params);
				var totalPages = parseInt($('#ReportViewerTotalPages').text());

				if (page == undefined || page == null || page < 1) {
					page = 1;
				} else if (page > totalPages) {
					page = totalPages;
				}

				$.get(""/Report/ViewReportPage/?reportPath=");
                EndContext();
                BeginContext(6678, 28, false);
#line 185 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Views\Report\ReportViewer.cshtml"
                                                     Write(Model.ReportPath.UrlEncode());

#line default
#line hidden
                EndContext();
                BeginContext(6706, 747, true);
                WriteLiteral(@"&page="" + page + ""&"" + urlParams)
				.done(function (data) {
					updateReportContent(data);
					hideLoadingProgress();

					if (afterReportLoadedCallback && typeof (afterReportLoadedCallback) == ""function"") {
						afterReportLoadedCallback();
					}
				})
				.fail(function (data) {
					$('.ReportViewerContent').html(""<div class='ReportViewerError'>Report failed to load, check report parameters...</div>"");
					hideLoadingProgress();
				});
			}

			function exportReport(element) {
				var params = $('.ParametersContainer :input').serializeArray();
				var urlParams = $.param(params);
				var format = $(element).attr('class').replace(""Export"", """");

				window.location.href = ""/Report/ExportReport/?reportPath=");
                EndContext();
                BeginContext(7454, 28, false);
#line 205 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Views\Report\ReportViewer.cshtml"
                                                                    Write(Model.ReportPath.UrlEncode());

#line default
#line hidden
                EndContext();
                BeginContext(7482, 785, true);
                WriteLiteral(@"&format="" + format + ""&"" + urlParams;
			}

			function updateReportContent(data) {
				if (data != undefined && data != null) {
					$('#ReportViewerCurrentPage').val(data.CurrentPage);
					$('#ReportViewerTotalPages').text(data.TotalPages);
					$('.ReportViewerContent').html($.parseHTML(data.Content));

					if (data.TotalPages <= 1) {
						$('.FirstPage').attr('disabled', true);
						$('.PreviousPage').attr('disabled', true);
						$('.NextPage').attr('disabled', true);
						$('.LastPage').attr('disabled', true);
					} else {
						$('.FirstPage').attr('disabled', false);
						$('.PreviousPage').attr('disabled', false);
						$('.NextPage').attr('disabled', false);
						$('.LastPage').attr('disabled', false);
					}
				}
			}
    </script>
");
                EndContext();
            }
            );
            BeginContext(8270, 2, true);
            WriteLiteral("\r\n");
            EndContext();
            DefineSection("Content", async() => {
                BeginContext(8290, 6, true);
                WriteLiteral("\r\n    ");
                EndContext();
                BeginContext(8297, 30, false);
#line 231 "C:\SSK\SKF\Source Backup\REP-Language-Update-30-05-2020\EMaintenance.7.0.1.2-prod-test\EMaintanance\Views\Report\ReportViewer.cshtml"
Write(Html.RenderReportViewer(Model));

#line default
#line hidden
                EndContext();
                BeginContext(8327, 2, true);
                WriteLiteral("\r\n");
                EndContext();
            }
            );
            BeginContext(8332, 407, true);
            WriteLiteral(@"
<style>
    .content-heading-pane {
        display: none;
    }

    .menubar,
    a.app-feedback,
    /*.ParametersContainer,*/
    .ClientMaster-wrapper,
    .header-menues,
    .top-menu {
        display: none;
    }

    td#oReportCell,
    td#oReportCell table,
    td#oReportCell table div {
        width: 100% !important;
        /*height: 100% !important;*/
    }

</style>");
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
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<AlanJuden.MvcReportViewer.ReportViewerModel> Html { get; private set; }
    }
}
#pragma warning restore 1591
