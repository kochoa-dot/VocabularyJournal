using Microsoft.EntityFrameworkCore;
using VocabularyJournal.Contracts;
using VocabularyJournal.Infraestructure;

namespace VocabularyJournal.Services
{
	public interface IReportsService
	{
		Task<List<AttendanceDto>> GetDailyAttendanceAsync(DateOnly date);
	}

	public class ReportsService(AppDbContext db) : IReportsService
	{
		public async Task<List<AttendanceDto>> GetDailyAttendanceAsync(DateOnly date)
		{
			var result = await db.Users
				.Select(u => new AttendanceDto(
					u.UserId,
					u.FullName,
					db.DailyTasks.Any(d => d.UserId == u.UserId && d.Date == date),
					date
				))
				.OrderBy(x => x.FullName)
				.ToListAsync();

			return result;
		}
	}
}
