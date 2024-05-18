# Use the official ASP.NET Core runtime image
FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /app

# Copy the pre-built application
COPY . .

# Set the entry point
ENTRYPOINT ["dotnet", "run"]