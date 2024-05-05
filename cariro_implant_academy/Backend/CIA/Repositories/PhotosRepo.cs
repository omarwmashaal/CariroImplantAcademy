using CIA.DataBases;
using CIA.Models;
using CIA.Repositories.Interfaces;
using Microsoft.AspNetCore.Hosting.Server;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel;
using System.IO;
using System.Xml.Linq;

namespace CIA.Repositories
{
    public class PhotosRepo : IPhotosRepo
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IConfiguration _configuration;
        private readonly IHostEnvironment _env;
        private readonly CIA_dbContext _dbContext;
        public PhotosRepo(CIA_dbContext dbContext, IHttpContextAccessor httpContextAccessor, IConfiguration configuration, IHostEnvironment env)
        {   
            _dbContext = dbContext;
            _configuration = configuration;
            _httpContextAccessor = httpContextAccessor;
            _env = env;
        }
        public async Task<int?> Save(IFormFile image, EnumImageType type)
        {
            String path = _env.ContentRootPath;
            Image myImage = new Image();
            try
            {
                using (var memoryStream = new MemoryStream())
                {
                    await image.CopyToAsync(memoryStream);                   

                    switch (type)
                    {
                        case EnumImageType.PatientProfile:
                            path += _configuration.GetValue<string>("ImagesDirectory:PatientProfile");
                            
                            break;
                        case EnumImageType.UserProfile:
                            path += _configuration.GetValue<string>("ImagesDirectory:UserProfile");
                            break;
                        case EnumImageType.IdBack:
                            path += _configuration.GetValue<string>("ImagesDirectory:IdBack");
                            break;
                        case EnumImageType.IdFront:
                            path += _configuration.GetValue<string>("ImagesDirectory:IdFront");
                            break;
                        case EnumImageType.Pros:
                            path += _configuration.GetValue<string>("ImagesDirectory:Pros");
                            break;
                        default: break;

                    }
                    if(!Directory.Exists(path))
                    {
                        Directory.CreateDirectory(path);
                    }
                    path = path + DateTime.Now.Ticks.ToString();
                    
                    FileStream file = new FileStream(path, FileMode.Create, FileAccess.Write);
                    memoryStream.WriteTo(file);
                    file.Close();

                }
                myImage.Directory = path;
                myImage.Type = type;
                _dbContext.Images.Add(myImage);
                _dbContext.SaveChanges();
                return myImage.Id;
            }
            catch (Exception ex) { return null; }



            //try
            //{
            //    using (var memoryStream = new MemoryStream())
            //    {
            //        await image.CopyToAsync(memoryStream);
            //        switch (type)
            //        {   
            //            case EnumImageType.PatientProfile:
            //                path += _configuration.GetValue<string>("ImagesDirectory:PatientProfile");
            //                break;
            //            case EnumImageType.UserProfile:
            //                path += _configuration.GetValue<string>("ImagesDirectory:UserProfile");
            //                break;
            //            case EnumImageType.IdBack:
            //                path += _configuration.GetValue<string>("ImagesDirectory:IdBack");
            //                break;
            //            case EnumImageType.IdFront:
            //                path += _configuration.GetValue<string>("ImagesDirectory:IdFront");
            //                break;
            //            case EnumImageType.Pros:
            //                path += _configuration.GetValue<string>("ImagesDirectory:Pros");
            //                break;
            //            default: break;

            //        }

            //        FileStream file = new FileStream(path + image.FileName, FileMode.Create, FileAccess.Write);
            //        memoryStream.WriteTo(file);
            //        file.Close();

            //    }
            //    return true;
            //}
            //catch (Exception ex) { return false; }


        }

        public async Task<String?> Get(int? id)
        {
            if (id == null) return null;
            var image = await _dbContext.Images.FirstOrDefaultAsync(x=>x.Id==id);
            if (image == null) return null;
            try
            {
                using (FileStream fileStream = new FileStream(image.Directory??"", FileMode.Open))
                {
                    using (var memoryStream = new MemoryStream())
                    {
                        fileStream.CopyTo(memoryStream);
                        byte[] byteImage = memoryStream.ToArray();
                        String base64 = Convert.ToBase64String(byteImage);
                        return base64;
                    }
                }
            }
            catch(Exception ex) { return null; }
            //try
            //{
            //    String path = _env.ContentRootPath;
            //    switch (type)
            //    {
            //        case EnumImageType.PatientProfile:
            //            path += _configuration.GetValue<string>("ImagesDirectory:PatientProfile");
            //            break;
            //        case EnumImageType.UserProfile:
            //            path += _configuration.GetValue<string>("ImagesDirectory:UserProfile");
            //            break;
            //        case EnumImageType.IdBack:
            //            path += _configuration.GetValue<string>("ImagesDirectory:IdBack");
            //            break;
            //        case EnumImageType.IdFront:
            //            path += _configuration.GetValue<string>("ImagesDirectory:IdFront");
            //            break;
            //        case EnumImageType.Pros:
            //            path += _configuration.GetValue<string>("ImagesDirectory:Pros");
            //            break;
            //        default: break;

            //    }
            //    path += fileName;
            //    using (FileStream fileStream = new FileStream(path, FileMode.Open))
            //    {
            //        using (var memoryStream = new MemoryStream())
            //        {
            //            fileStream.CopyTo(memoryStream);
            //            byte[] byteImage = memoryStream.ToArray();
            //            String base64 = Convert.ToBase64String(byteImage);
            //            return base64;
            //        }
            //    }
            //}
            //catch(Exception ex) { return null; }
            
 
        }
    }
}
