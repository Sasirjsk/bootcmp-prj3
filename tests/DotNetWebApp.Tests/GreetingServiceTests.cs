using DotNetWebApp.Services;
using Xunit;

namespace DotNetWebApp.Tests
{
    public class GreetingServiceTests
    {
        [Fact]
        public void Greet_ReturnsExpectedMessage()
        {
            // Arrange
            var svc = new GreetingService();

            // Act
            var result = svc.Greet("World");

            // Assert
            Assert.Equal("Hello, World!", result);
        }
    }
}

