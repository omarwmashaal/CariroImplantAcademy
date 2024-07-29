


using System;
using System.IdentityModel.Tokens.Jwt;
using System.Management;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using CIA.Repositories.Interfaces;
using Hardware.Info;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Microsoft.IdentityModel.Tokens;


public sealed class Authenticator : IAuthenticator
{
 


    private string GetCpuInfo()
    {
        string cpuId = string.Empty;

        try
        {
            using (ManagementObjectSearcher mos = new ManagementObjectSearcher("select ProcessorId from Win32_Processor"))
            {
                foreach (ManagementObject mo in mos.Get())
                {
                    cpuId = mo["ProcessorId"].ToString();
                    break;
                }
            }
        }
        catch (Exception ex)
        {
            // Handle exceptions
            Console.WriteLine($"Error retrieving CPU ID: {ex.Message}");
        }

        return cpuId;
    }
    private string GetBiosSerialNumber()
    {
        string serialNumber = string.Empty;

        try
        {
            using (ManagementObjectSearcher mos = new ManagementObjectSearcher("select SerialNumber from Win32_BIOS"))
            {
                foreach (ManagementObject mo in mos.Get())
                {
                    serialNumber = mo["SerialNumber"].ToString();
                    break;
                }
            }
        }
        catch (Exception ex)
        {
            // Handle exceptions
            Console.WriteLine($"Error retrieving BIOS serial number: {ex.Message}");
        }

        return serialNumber;
    }


    private string GetHash(string input)
    {
        using (SHA256 sha256Hash = SHA256.Create())
        {
            byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(input));
            StringBuilder builder = new StringBuilder();
            for (int i = 0; i < bytes.Length; i++)
            {
                builder.Append(bytes[i].ToString("x2"));
            }
            return builder.ToString();
        }
    }

    public string GetFingerPrint()
    {
        string cpuInfo = GetCpuInfo();
        string biosInfo = GetBiosSerialNumber();

        // Combine CPU and RAM information
        string machineInfo = cpuInfo + biosInfo;

        // Create fingerprint from combined information
        return GetHash(machineInfo);
    }
}
