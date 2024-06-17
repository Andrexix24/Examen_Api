using System.ComponentModel.DataAnnotations;

namespace Examen_Api.Models
{
    public class Pago
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string Placa { get; set; }

        [Required]
        public string NombrePeaje { get; set; }

        [Required]
        [RegularExpression(@"^[IVXVI]+$|^I{1,5}$")]
        public string IdCategoriaTarifa { get; set; }

        [Required]
        public string FechaRegistro { get; set; }

        [Required]
        [Range(0, int.MaxValue)]
        public int Valor {  get; set; }
    }
}
