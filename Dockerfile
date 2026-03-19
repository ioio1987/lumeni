# Build 
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# ყურადღება: ბილიკი უნდა ემთხვეოდეს GitHub-ზე არსებულ ფოლდერს
COPY ["UserManagement.API/UserManagement.API.csproj", "UserManagement.API/"]
RUN dotnet restore "UserManagement.API/UserManagement.API.csproj"

COPY . .
WORKDIR "/src/UserManagement.API"
RUN dotnet publish -c Release -o /app/publish /p:UseAppHost=false

# Run 
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

# პორტი
EXPOSE 8080

# დარწმუნდით რომ DLL-ის სახელი ზუსტია
ENTRYPOINT ["dotnet", "UserManagement.API.dll"]