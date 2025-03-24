# Use the official .NET 9.0 SDK image
FROM mcr.microsoft.com/dotnet/sdk:9.0

# Set the working directory inside the container
WORKDIR /app

# Copy the GitHub Actions runner working directory into the container
COPY . .

# Install any additional dependencies (if needed)
RUN apt-get update && apt-get install -y \
    curl \
    unzip

# Display user and environment for debugging
RUN whoami
RUN env
RUN dotnet --info

# Restore dependencies
RUN dotnet restore src/sdk/PnP.Core.Admin.Test/PnP.Core.Admin.Test.csproj

# Uncomment TestCommon.Instance.Mocking line
RUN sed -i 's|//TestCommon.Instance.Mocking = false;|TestCommon.Instance.Mocking = false;|' src/sdk/PnP.Core.Admin.Test/SharePoint/PermissionRequestsTests.cs

# Run the tests
CMD ["dotnet", "test", "src/sdk/PnP.Core.Admin.Test/PnP.Core.Admin.Test.csproj", "--logger", "console;verbosity=detailed", "--filter", "PermissionRequestsTests"]
