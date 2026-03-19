# Build სტადია
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# კოდის დაკოპირება და Restore
COPY ["Syllogia.AuthServer/Syllogia.AuthServer.csproj", "Syllogia.AuthServer/"]
RUN dotnet restore "Syllogia.AuthServer/Syllogia.AuthServer.csproj"

COPY . .
WORKDIR "/src/Syllogia.AuthServer"
RUN dotnet publish -c Release -o /app/publish

# Run სტადია
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

# პორტი, რომელსაც კონტეინერი გამოიყენებს შიგნით
EXPOSE 8080

ENTRYPOINT ["dotnet", "Syllogia.AuthServer.dll"]