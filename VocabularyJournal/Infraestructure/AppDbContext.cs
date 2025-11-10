using Microsoft.EntityFrameworkCore;
using VocabularyJournal.Domain.Entities;

namespace VocabularyJournal.Infraestructure
{
	public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
	{
		public DbSet<User> Users => Set<User>();
		public DbSet<DailyTask> DailyTasks => Set<DailyTask>();
		public DbSet<WordEntry> WordEntries => Set<WordEntry>();
	}
}
