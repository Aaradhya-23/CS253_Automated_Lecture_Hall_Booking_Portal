


import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('bookings', '0014_alter_booking_token_expiry'),
    ]

    operations = [
        migrations.AlterField(
            model_name='booking',
            name='token_expiry',

            field=models.DateTimeField(default=datetime.datetime(2025, 3, 27, 11, 59, 11, 548413, tzinfo=datetime.timezone.utc)),
        )
    ]
