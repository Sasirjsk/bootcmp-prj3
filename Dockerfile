# Use official .NET 8 SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy everything and restore dependencies
COPY . .
RUN dotnet restore

# Build and publish the app in release mode
RUN dotnet publish -c Release -o /out

# Use a lightweight runtime image for deployment
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copy published output from build stage
COPY --from=build /out ./

# Expose port 5000 instead of 8080 (Jenkins uses 8080)
EXPOSE 5000

# Start the web application
ENTRYPOINT ["dotnet", "DotNetWebApp.dll"]
