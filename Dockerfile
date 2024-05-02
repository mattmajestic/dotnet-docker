# Use the Microsoft's .NET SDK image to build the project
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Copy the C# and .csproj files
COPY Program.cs ./
COPY Program.csproj ./

# Compile the project
RUN dotnet publish -c Release -o out Program.csproj

# Generate the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app/out .

# Expose port 80
EXPOSE 80

ENTRYPOINT ["dotnet", "Program.dll"]