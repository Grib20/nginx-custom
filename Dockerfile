FROM nginx:alpine

# Установка curl для healthcheck
RUN apk add --no-cache curl

# Создание директории для логов
RUN mkdir -p /var/log/nginx

# Копирование конфигурации nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Копирование всех статических файлов
COPY public_html/ /usr/share/nginx/html/

# Установка правильных прав доступа
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chown -R nginx:nginx /var/log/nginx

# Открытие портов
EXPOSE 80

# Healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/health || exit 1

# Запуск nginx
CMD ["nginx", "-g", "daemon off;"]
