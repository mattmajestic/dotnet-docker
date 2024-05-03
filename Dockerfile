# Use the official .NET SDK image with .NET 8.0 support as a build stage
FROM mcr.microsoft.com/dotnet/sdk:6.0.100 AS build
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY MyBlazorApp.csproj .
RUN dotnet restore

# Copy everything else and build the application
COPY . .
RUN dotnet publish -c Release -o out

# Use the official ASP.NET Core runtime image for the final stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "MyBlazorApp.dll"]
