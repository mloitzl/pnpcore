using System.Security.Cryptography.X509Certificates;

X509Store store = new X509Store("My", StoreLocation.CurrentUser);

store.Open(OpenFlags.ReadOnly);
X509Certificate2Collection col = store.Certificates;

foreach (X509Certificate2 cert in col)
{
    Console.WriteLine($"Subject: {cert.Subject}");
    Console.WriteLine($"Issuer: {cert.Issuer}");
    Console.WriteLine($"Valid From: {cert.NotBefore}");
    Console.WriteLine($"Valid To: {cert.NotAfter}");
    Console.WriteLine($"Thumbprint: {cert.Thumbprint}");
    Console.WriteLine();
}