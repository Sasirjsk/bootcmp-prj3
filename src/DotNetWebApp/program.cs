using DotNetWebApp.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services
builder.Services.AddRazorPages();
builder.Services.AddSingleton<IGreetingService, GreetingService>();

var app = builder.Build();

// Simple error handling for non-dev
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
}

app.UseStaticFiles();
app.UseRouting();
app.MapRazorPages();

// Health + demo API
app.MapGet("/health", () => Results.Ok(new { status = "Healthy" }));
app.MapGet("/api/greet", (IGreetingService svc) => new { message = svc.Greet("Developer") });

app.Run();

