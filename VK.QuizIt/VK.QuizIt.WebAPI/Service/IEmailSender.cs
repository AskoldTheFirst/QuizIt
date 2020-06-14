using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace VK.QuizIt.WebAPI.Service
{
    public interface IEmailSender
    {
        Task SendEmailAsync(string fromAddress, string toAddress, string subject, string message);
    }
}
