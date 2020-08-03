using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EMaintanance.ViewModels
{
    public class ProgramTypeMapViewModel
    {
        public int PTMappingId { get; set; }
        public int PTMappingTId { get; set; }
        public int ProgramTypeId { get; set; }
        public int ClientSiteId { get; set; }
        public int LanguageId { get; set; }
        public int UserId { get; set; }
        public string Active { get; set; }
    }
}
