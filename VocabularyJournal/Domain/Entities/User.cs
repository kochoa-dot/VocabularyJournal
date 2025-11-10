namespace VocabularyJournal.Domain.Entities
{
	public class User
	{
		public int UserId { get; set; }
		public string FullName { get; set; }
		public string Email { get; set; }
		public string PasswordHash { get; set; }
		public DateTime CreatedAt { get; set; } = DateTime.Now;

		public ICollection<DailyTask> DailyTasks { get; set; } = new List<DailyTask>();
	}
}
