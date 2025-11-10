using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VocabularyJournal.Contracts;
using VocabularyJournal.Services;

namespace VocabularyJournal.Controllers
{
	[ApiController]
	[Route("api/[controller]")]
	[Authorize]
	public class ReportsController(IReportsService reports) : ControllerBase
	{
		[HttpGet("attendance")]
		public async Task<ActionResult<List<AttendanceDto>>> GetAttendance([FromQuery] DateOnly? date = null)
		{
			var targetDate = date ?? DateOnly.FromDateTime(DateTime.UtcNow);
			var result = await reports.GetDailyAttendanceAsync(targetDate);
			return Ok(result);
		}
	}
}
